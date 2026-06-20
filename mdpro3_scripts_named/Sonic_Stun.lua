--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 战斗无力化音速  (ID: 93138457)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：对方怪兽的攻击宣言时才能发动。那次攻击无效。那之后，可以从手卡·卡组把1只「科技属」怪兽或者4星以下的调整特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--バトル・スタン・ソニック
function c93138457.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c93138457.condition)
	e1:SetTarget(c93138457.target)
	e1:SetOperation(c93138457.activate)
	c:RegisterEffect(e1)
end
function c93138457.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c93138457.filter(c,e,tp)
	return (c:IsSetCard(0x27) or (c:IsLevelBelow(4) and c:IsType(TYPE_TUNER)))
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c93138457.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c93138457.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c93138457.filter,tp,LOCATION_DECK+LOCATION_HAND,0,nil,e,tp)
	if Duel.NegateAttack() and #g>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.SelectYesNo(tp,aux.Stringid(93138457,0)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end
