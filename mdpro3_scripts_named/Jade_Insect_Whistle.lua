--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 翡翠虫笛  (ID: 95214051)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方从卡组中选择1张昆虫族怪兽卡，那张卡放在卡组最上面。
--[[ __CARD_HEADER_END__ ]]

--翡翠の蟲笛
function c95214051.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c95214051.target)
	e1:SetOperation(c95214051.activate)
	c:RegisterEffect(e1)
end
function c95214051.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>0 end
end
function c95214051.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(95214051,0))
	local g=Duel.SelectMatchingCard(1-tp,Card.IsRace,1-tp,LOCATION_DECK,0,1,1,nil,RACE_INSECT)
	local tc=g:GetFirst()
	if tc then
		Duel.ShuffleDeck(1-tp)
		Duel.MoveSequence(tc,SEQ_DECKTOP)
		Duel.ConfirmDecktop(1-tp,1)
	end
end
