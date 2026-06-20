--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 穿孔虫  (ID: 88733579)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level 2
-- ATK 1100 | DEF 200
--
-- Effect Text:
-- 这张卡给与对方战斗伤害的时候，从自己的卡组取出1张「寄生虫 帕拉赛德」，之后在卡组洗切后放在卡组最上面。
--[[ __CARD_HEADER_END__ ]]

--穿孔虫
function c88733579.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(88733579,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c88733579.condition)
	e1:SetTarget(c88733579.target)
	e1:SetOperation(c88733579.operation)
	c:RegisterEffect(e1)
end
function c88733579.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==1-tp
end
function c88733579.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_DECK,0,1,nil,27911549)
		and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>1 end
end
function c88733579.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(88733579,1))
	local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK,0,1,1,nil,27911549)
	local tc=g:GetFirst()
	if tc then
		Duel.ShuffleDeck(tp)
		Duel.MoveSequence(tc,SEQ_DECKTOP)
		Duel.ConfirmDecktop(tp,1)
	end
end
