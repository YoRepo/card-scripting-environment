--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Majesty Maiden, the True Dracocaster  (ID: 95004025)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Wyrm
-- Level: 5
-- ATK 2300 | DEF 1500
-- Setcode: 0xf9
-- Scope: OCG / TCG
--
-- Effect Text:
-- To Tribute Summon this card face-up, you can Tribute a Continuous Spell/Trap you control, instead of
-- a monster.
-- Once per turn, when your opponent activates a card or effect while you control this Tribute Summoned
-- monster (Quick Effect): You can add 1 "True Draco" or "True King" monster from your Deck to your
-- hand.
--[[ __CARD_HEADER_END__ ]]

--真竜導士マジェスティM
function c95004025.initial_effect(c)
	--summon with s/t
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_ADD_EXTRA_TRIBUTE)
	e1:SetTargetRange(LOCATION_SZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_CONTINUOUS))
	e1:SetValue(POS_FACEUP_ATTACK)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(95004025,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c95004025.thcon)
	e2:SetTarget(c95004025.thtg)
	e2:SetOperation(c95004025.thop)
	c:RegisterEffect(e2)
end
function c95004025.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_ADVANCE) and rp==1-tp
end
function c95004025.thfilter(c)
	return c:IsSetCard(0xf9) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c95004025.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c95004025.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c95004025.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c95004025.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
