--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 时间次元洞会馆  (ID: 90615639)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 137
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：自己卡组洗切。那之后，自己卡组最上面的卡翻开。翻开的卡是可以通常召唤的怪兽的场合，那只怪兽特殊召唤。不是的场合或者不能特殊召唤的场合，翻开的卡回到卡组最上面或最下面。
--[[ __CARD_HEADER_END__ ]]

--タイム・ディメンションホール
local s,id,o=GetID()
function s.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=1 end
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<1 then return false end
	Duel.ShuffleDeck(tp)
	Duel.BreakEffect()
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	Duel.DisableShuffleCheck()
	if tc:IsSummonableCard() and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and tc:IsCanBeSpecialSummoned(e,0,tp,false,false) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	else
		if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>1
			and Duel.SelectOption(tp,aux.Stringid(id,1),aux.Stringid(id,2))==1 then
			Duel.MoveSequence(tc,1)
		end
	end
end
