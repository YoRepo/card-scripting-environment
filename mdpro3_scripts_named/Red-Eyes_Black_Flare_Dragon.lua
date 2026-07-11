--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Red-Eyes Black Flare Dragon  (ID: 30079770)
-- Type: Monster / Effect / Gemini
-- Attribute: DARK
-- Race: Dragon
-- Level: 7
-- ATK 2400 | DEF 2000
-- Setcode: 0x3b
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is treated as a Normal Monster while face-up on the field or in the Graveyard.
-- While this card is a Normal Monster on the field, you can Normal Summon it to have it become an
-- Effect Monster with this effect.
-- ● If damage calculation is performed involving this card, at the end of the Battle Phase: You can
-- inflict damage to your opponent equal to this card's original ATK.
-- You can only use this effect of "Red-Eyes Black Flare Dragon" once per turn.
--[[ __CARD_HEADER_END__ ]]

--真紅眼の黒炎竜
function c30079770.initial_effect(c)
	aux.EnableDualAttribute(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCountLimit(1,30079770)
	e1:SetCondition(c30079770.damcon)
	e1:SetTarget(c30079770.damtg)
	e1:SetOperation(c30079770.damop)
	c:RegisterEffect(e1)
end
function c30079770.damcon(e,tp,eg,ep,ev,re,r,rp)
	return aux.IsDualState(e) and e:GetHandler():GetBattledGroupCount()>0
end
function c30079770.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local atk=e:GetHandler():GetBaseAttack()
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,atk)
end
function c30079770.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local atk=c:GetBaseAttack()
		Duel.Damage(1-tp,atk,REASON_EFFECT)
	end
end
