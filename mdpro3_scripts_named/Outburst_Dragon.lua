--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 爆发龙  (ID: 87263576)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Dragon
-- Level 8
-- ATK 2100 | DEF 2800
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己场上有怪兽存在的场合才能发动。这张卡从手卡特殊召唤。那之后，这张卡以外的自己场上的怪兽全部破坏。只要这个效果特殊召唤的这张卡在怪兽区域表侧表示存在，自己不是暗属性怪兽不能特殊召唤。
-- ②：对方主要阶段才能发动。用包含这张卡的自己场上的怪兽为连接素材把1只龙族连接怪兽连接召唤。
--[[ __CARD_HEADER_END__ ]]

--アウトバースト・ドラゴン
function c87263576.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(87263576,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,87263576)
	e1:SetCondition(c87263576.spcon)
	e1:SetTarget(c87263576.sptg)
	e1:SetOperation(c87263576.spop)
	c:RegisterEffect(e1)
	--link summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(87263576,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,87263577)
	e2:SetCondition(c87263576.lkcon)
	e2:SetTarget(c87263576.lktg)
	e2:SetOperation(c87263576.lkop)
	c:RegisterEffect(e2)
end
function c87263576.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)>0
end
function c87263576.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,e:GetHandler())
	if #g>0 then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
	end
end
function c87263576.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local res=false
		if Duel.SpecialSummonStep(c,0,tp,tp,false,false,POS_FACEUP) then
			res=true
			local e1=Effect.CreateEffect(c)
			e1:SetDescription(aux.Stringid(87263576,2))
			e1:SetProperty(EFFECT_FLAG_CLIENT_HINT+EFFECT_FLAG_PLAYER_TARGET)
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			e1:SetAbsoluteRange(tp,1,0)
			e1:SetTarget(c87263576.splimit)
			c:RegisterEffect(e1,true)
		end
		Duel.SpecialSummonComplete()
		local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,e:GetHandler())
		if res and #g>0 then
			Duel.BreakEffect()
			Duel.Destroy(g,REASON_EFFECT)
		end
	end
end
function c87263576.splimit(e,c)
	return not c:IsAttribute(ATTRIBUTE_DARK)
end
function c87263576.lkcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()~=tp and (ph==PHASE_MAIN1 or ph==PHASE_MAIN2)
end
function c87263576.lkfilter(c,lc)
	return c:IsRace(RACE_DRAGON) and c:IsLinkSummonable(nil,lc)
end
function c87263576.lktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c87263576.lkfilter,tp,LOCATION_EXTRA,0,1,nil,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c87263576.lkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsControler(1-tp) or not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local g=Duel.GetMatchingGroup(c87263576.lkfilter,tp,LOCATION_EXTRA,0,nil,c)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.LinkSummon(tp,sg:GetFirst(),nil,c)
	end
end
