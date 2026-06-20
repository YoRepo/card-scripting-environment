--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 高傲自豪之耀圣诗-耀圣之诗  (ID: 5559570)
-- Type: Monster / Effect / Synchro
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 10
-- ATK 3100 | DEF 1800
-- Setcode: 472
--
-- Effect Text:
-- 调整＋调整以外的魔法师族怪兽1只
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：只要这张卡在中央的主要怪兽区域存在，双方不用中央的主要怪兽区域的怪兽不能攻击宣言。
-- ②：这张卡在中央的主要怪兽区域存在的场合，自己·对方的主要阶段才能发动。这张卡回到额外卡组，从自己的手卡·卡组·墓地各把最多1只「耀圣」怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--誇り高き耀聖の詩－エルフェンノーツ
local s,id,o=GetID()
function s.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsRace,RACE_SPELLCASTER),1,1)
	c:EnableReviveLimit()
	--cannot announce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetCondition(s.ancondition)
	e1:SetTarget(s.antarget)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOEXTRA)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e2:SetCountLimit(1,id)
	e2:SetCondition(s.spcon)
	e2:SetTarget(s.sptg)
	e2:SetOperation(s.spop)
	c:RegisterEffect(e2)
end
function s.ancondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSequence()==2
end
function s.antarget(e,c)
	return c:GetSequence()~=2
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsMainPhase() and e:GetHandler():GetSequence()==2
end
function s.spfilter(c,e,tp)
	return c:IsSetCard(0x1d8) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return e:GetHandler():IsAbleToExtra()
		and Duel.GetMZoneCount(tp,c)>0
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_TOEXTRA,c,1,0,0)
end
function s.gcheck(g)
	if #g==1 then return true end
	return g:FilterCount(Card.IsLocation,nil,LOCATION_DECK)<=1
		and g:FilterCount(Card.IsLocation,nil,LOCATION_HAND)<=1
		and g:FilterCount(Card.IsLocation,nil,LOCATION_GRAVE)<=1
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToChain() and Duel.SendtoDeck(c,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)>0
		and c:IsLocation(LOCATION_EXTRA)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(aux.NecroValleyFilter(s.spfilter),tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) then
		local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(s.spfilter),tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,nil,e,tp)
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		if ft>0 and #g>0 then
			if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg=g:SelectSubGroup(tp,s.gcheck,false,1,ft)
			if sg then
				Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
			end
		end
	end
end
