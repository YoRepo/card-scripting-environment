--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Elemental HERO Cosmo Neos  (ID: 90050480)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 11
-- ATK 3500 | DEF 3000
-- Setcode: 0x3008, 0x9
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Elemental HERO Neos" + 3 "Neo-Spacian" monsters with different Attributes
-- Must first be Special Summoned (from your Extra Deck) by shuffling the above cards you control into
-- the Deck.
-- (You do not use "Polymerization".)
-- If this card is Special Summoned from the Extra Deck: You can activate this effect; for the rest of
-- this turn, your opponent cannot activate cards, also cards your opponent controls cannot activate
-- their effects.
-- Your opponent cannot activate cards or effects in response to this effect's activation.
-- Once per turn, during the End Phase: Shuffle this card into the Extra Deck, and if you do, destroy
-- all cards your opponent controls.
--[[ __CARD_HEADER_END__ ]]

--E・HERO コスモ・ネオス
function c90050480.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,89943723,c90050480.ffilter,3,true,true)
	aux.AddContactFusionProcedure(c,Card.IsAbleToDeckOrExtraAsCost,LOCATION_ONFIELD,0,aux.ContactFusionSendToDeck(c))
	--special summon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetValue(c90050480.splimit)
	c:RegisterEffect(e1)
	--return
	aux.EnableNeosReturn(c,c90050480.retop,c90050480.set_category)
	--act limit
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(90050480,1))
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	e5:SetProperty(EFFECT_FLAG_DELAY)
	e5:SetCondition(c90050480.limcon)
	e5:SetTarget(c90050480.limtg)
	e5:SetOperation(c90050480.limop)
	c:RegisterEffect(e5)
end
c90050480.material_setcode=0x8
function c90050480.ffilter(c,fc,sub,mg,sg)
	return c:IsType(TYPE_MONSTER) and c:IsFusionSetCard(0x1f) and (not sg or not sg:Filter(Card.IsFusionSetCard,nil,0x1f):IsExists(Card.IsFusionAttribute,1,c,c:GetFusionAttribute()))
end
function c90050480.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA)
end
function c90050480.set_category(e,tp,eg,ep,ev,re,r,rp)
	e:SetCategory(CATEGORY_TODECK+CATEGORY_DESTROY)
	local g=Duel.GetMatchingGroup(nil,tp,0,LOCATION_ONFIELD,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function c90050480.retop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SendtoDeck(c,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	if c:IsLocation(LOCATION_EXTRA) then
		local g=Duel.GetMatchingGroup(nil,tp,0,LOCATION_ONFIELD,nil)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
function c90050480.limcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonLocation(LOCATION_EXTRA)
end
function c90050480.limtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetChainLimit(c90050480.chainlm)
end
function c90050480.chainlm(e,rp,tp)
	return tp==rp
end
function c90050480.limop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetValue(c90050480.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c90050480.aclimit(e,re,tp)
	return re:GetHandler():IsOnField() or re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
