--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Tri-Gate Wizard  (ID: 32617464)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Cyberse
-- Link Rating: 3
-- Link Arrows: Top, Left, Right
-- ATK 2200
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2+ monsters, except Tokens
-- Gains these effects based on the number of monsters co-linked to this card.
-- ● 1+: If a monster co-linked to this card battles your opponent's monster, any battle damage it
-- inflicts to your opponent is doubled.
-- ● 2+: Once per turn: You can target 1 card on the field; banish it.
-- ● 3: Once per turn, when a card or effect is activated (Quick Effect): You can negate the
-- activation, and if you do, banish that card.
--[[ __CARD_HEADER_END__ ]]

--トライゲート・ウィザード
function c32617464.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,c32617464.matfilter,2)
	c:EnableReviveLimit()
	--double damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c32617464.damtg)
	e1:SetValue(aux.ChangeBattleDamage(1,DOUBLE_DAMAGE))
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(32617464,0))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c32617464.rmcon)
	e2:SetTarget(c32617464.rmtg)
	e2:SetOperation(c32617464.rmop)
	c:RegisterEffect(e2)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(32617464,1))
	e3:SetCategory(CATEGORY_NEGATE+CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c32617464.negcon)
	e3:SetTarget(aux.nbtg)
	e3:SetOperation(c32617464.negop)
	c:RegisterEffect(e3)
end
function c32617464.matfilter(c)
	return not c:IsLinkType(TYPE_TOKEN)
end
function c32617464.damtg(e,c)
	local lg=e:GetHandler():GetMutualLinkedGroup()
	return lg:IsContains(c) and c:GetBattleTarget()~=nil and c:GetBattleTarget():GetControler()==1-e:GetHandlerPlayer()
end
function c32617464.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetMutualLinkedGroupCount()>=2
end
function c32617464.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c32617464.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
function c32617464.negcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return not c:IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev) and c:GetMutualLinkedGroupCount()>=3
end
function c32617464.negop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Remove(eg,POS_FACEUP,REASON_EFFECT)
	end
end
