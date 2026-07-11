--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Dark Magical Circle  (ID: 47222536)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is activated: Look at the top 3 cards of your Deck, then you can reveal 1 of them
-- that is "Dark Magician" or a Spell/Trap that mentions "Dark Magician", and add it to your hand, also
-- place the remaining cards on top of your Deck in any order.
-- If "Dark Magician" is Normal or Special Summoned to your field (except during the Damage Step): You
-- can target 1 card your opponent controls; banish it.
-- You can only use each effect of "Dark Magical Circle" once per turn.
--[[ __CARD_HEADER_END__ ]]

--黒の魔導陣
function c47222536.initial_effect(c)
	aux.AddCodeList(c,46986414)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,47222536)
	e1:SetTarget(c47222536.target)
	e1:SetOperation(c47222536.activate)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(47222536,1))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,47222537)
	e2:SetCondition(c47222536.rmcon)
	e2:SetTarget(c47222536.rmtg)
	e2:SetOperation(c47222536.rmop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c47222536.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>2 end
end
function c47222536.filter(c)
	return (aux.IsCodeListed(c,46986414) and c:IsType(TYPE_SPELL+TYPE_TRAP) or c:IsCode(46986414)) and c:IsAbleToHand()
end
function c47222536.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<3 then return end
	local g=Duel.GetDecktopGroup(tp,3)
	Duel.ConfirmCards(tp,g)
	if g:IsExists(c47222536.filter,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(47222536,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:FilterSelect(tp,c47222536.filter,1,1,nil)
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
		Duel.ShuffleHand(tp)
		Duel.SortDecktop(tp,tp,2)
	else Duel.SortDecktop(tp,tp,3) end
end
function c47222536.cfilter(c,tp)
	return c:IsFaceup() and c:IsCode(46986414) and c:IsControler(tp)
end
function c47222536.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c47222536.cfilter,1,nil,tp)
end
function c47222536.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c47222536.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
