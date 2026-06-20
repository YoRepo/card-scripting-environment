--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 冥占术姬 塔罗幽巫女  (ID: 42932862)
-- Type: Monster / Effect / Ritual / Toon
-- Attribute: DARK
-- Race: Fairy
-- Level 9
-- ATK 1200 | DEF 2700
-- Setcode: 204
--
-- Effect Text:
-- 「冥占术的仪式」降临。这张卡用仪式召唤以及「圣占术姬 塔罗光巫女」的效果才能特殊召唤。这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡反转的场合才能发动。从卡组把1只反转怪兽里侧守备表示特殊召唤。
-- ②：自己·对方回合，可以从以下效果选择1个发动。
-- ●选自己场上的里侧表示怪兽任意数量变成表侧守备表示。
-- ●选自己场上的表侧表示怪兽任意数量变成里侧守备表示。
--[[ __CARD_HEADER_END__ ]]

--冥占術姫タロットレイス
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,8428836,94997874)
	c:EnableReviveLimit()
	--spsummon condition
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(aux.ritlimit)
	c:RegisterEffect(e0)
	--Special Summon Flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--select position
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(TIMING_END_PHASE,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE+TIMING_STANDBY_PHASE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,id+o)
	e2:SetTarget(s.postg)
	e2:SetOperation(s.posop)
	c:RegisterEffect(e2)
end
function s.spfilter(c,e,tp)
	return c:IsType(TYPE_FLIP) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)
		Duel.ConfirmCards(1-tp,tc)
	end
end
function s.posfilter(c)
	return c:IsFaceup() and c:IsCanTurnSet()
end
function s.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,LOCATION_MZONE,0,nil)
	local mg=Duel.GetMatchingGroup(s.posfilter,tp,LOCATION_MZONE,0,nil)
	if chk==0 then return #g>0 or #mg>0 end
	local op=0
	if #g>0 and #mg>0 then
		op=Duel.SelectOption(tp,aux.Stringid(id,2),aux.Stringid(id,3))
	elseif #g>0 then
		op=Duel.SelectOption(tp,aux.Stringid(id,2))
	else
		op=Duel.SelectOption(tp,aux.Stringid(id,3))+1
	end
	e:SetLabel(op)
	if op==0 then
		e:SetCategory(CATEGORY_POSITION)
	else
		e:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,nil,1,0,0)
end
function s.posop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,LOCATION_MZONE,0,nil)
	local mg=Duel.GetMatchingGroup(s.posfilter,tp,LOCATION_MZONE,0,nil)
	if e:GetLabel()==0 then
		if g:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
			local sg=g:Select(tp,1,g:GetCount(),nil)
			if sg:GetCount()>0 then
				Duel.HintSelection(sg)
				Duel.ChangePosition(sg,POS_FACEUP_DEFENSE)
			end
		end
	else
		if mg:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
			local sg1=mg:Select(tp,1,mg:GetCount(),nil)
			if sg1:GetCount()>0 then
				Duel.HintSelection(sg1)
				Duel.ChangePosition(sg1,POS_FACEDOWN_DEFENSE)
			end
		end
	end
end
