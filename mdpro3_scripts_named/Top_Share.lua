--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 业界首位  (ID: 90359458)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从卡组选1张卡，给双方确认并在卡组最上面放置。那之后，对方从自身卡组选1张卡，给双方确认并在自身卡组最上面放置。
--[[ __CARD_HEADER_END__ ]]

--トップ・シェア
function c90359458.initial_effect(c)
	--set top
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90359458,1))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,90359458+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c90359458.target)
	e1:SetOperation(c90359458.activate)
	c:RegisterEffect(e1)
end
function c90359458.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=2 and Duel.GetFieldGroupCount(1-tp,LOCATION_DECK,0)>=2 end
end
function c90359458.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(90359458,0))
	local tc=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_DECK,0,1,1,nil):GetFirst()
	Duel.ShuffleDeck(tp)
	Duel.MoveSequence(tc,SEQ_DECKTOP)
	Duel.ConfirmDecktop(tp,1)
	if Duel.GetFieldGroupCount(1-tp,LOCATION_DECK,0)<2 then return end
	Duel.BreakEffect()
	Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(90359458,0))
	local tc2=Duel.SelectMatchingCard(1-tp,nil,1-tp,LOCATION_DECK,0,1,1,nil):GetFirst()
	Duel.ShuffleDeck(1-tp)
	Duel.MoveSequence(tc2,SEQ_DECKTOP)
	Duel.ConfirmDecktop(1-tp,1)
end
