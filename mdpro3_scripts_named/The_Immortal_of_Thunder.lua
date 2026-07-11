--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: The Immortal of Thunder  (ID: 84926738)
-- Type: Monster / Effect / Flip
-- Attribute: LIGHT
-- Race: Thunder
-- Level: 4
-- ATK 1500 | DEF 1300
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: Increase your Life Points by 3000 points.
-- When this card is sent from the field to the Graveyard, you lose 5000 Life Points.
--[[ __CARD_HEADER_END__ ]]

--雷仙人
function c84926738.initial_effect(c)
	--flip effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(84926738,0))
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c84926738.flipop)
	c:RegisterEffect(e1)
	--lpchange
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(84926738,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetTarget(c84926738.lptg)
	e2:SetOperation(c84926738.lpop)
	c:RegisterEffect(e2)
end
function c84926738.flipop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Recover(tp,3000,REASON_EFFECT)
	if c:IsLocation(LOCATION_MZONE+LOCATION_GRAVE) then
		c:RegisterFlagEffect(84926738,RESET_EVENT+0x57a0000,0,0)
	end
end
function c84926738.lptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(84926738)~=0 end
end
function c84926738.lpop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetLP(tp,Duel.GetLP(tp)-5000)
end
