--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Dark Angel  (ID: 28593329)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fairy
-- Level: 5
-- ATK 0 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- When your Fairy monster is targeted for an attack: You can Tribute it and send this card from your
-- hand to the GY, then target 1 face-up monster you control; change the attack target to your targeted
-- monster, and if you do, it gains ATK equal to the original ATK of the Tributed monster, until the
-- end of this turn.
--[[ __CARD_HEADER_END__ ]]

--ダーク・エンジェル
function c28593329.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(28593329,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c28593329.cost)
	e1:SetTarget(c28593329.target)
	e1:SetOperation(c28593329.activate)
	c:RegisterEffect(e1)
end
function c28593329.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local at=Duel.GetAttackTarget()
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost()
		and at and at:IsControler(tp) and at:IsRace(RACE_FAIRY) and at:IsReleasable() end
	e:SetLabel(at:GetBaseAttack())
	Duel.Release(at,REASON_COST)
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c28593329.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local at=Duel.GetAttackTarget()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() and chkc~=at end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,at) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,at)
end
function c28593329.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if tc:IsRelateToEffect(e) then
		Duel.ChangeAttackTarget(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
