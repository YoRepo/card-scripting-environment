--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Number 23: Lancelot, Dark Knight of the Underworld  (ID: 66547759)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Zombie
-- Rank: 8
-- ATK 2000 | DEF 1500
-- Setcode: 0x48, 0xa8
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Level 8 monsters
-- This card can attack your opponent directly while it has Xyz Material.
-- When this card inflicts battle damage to your opponent: You can target 1 face-up monster your
-- opponent controls; destroy it.
-- Once per turn, during either player's turn, when a Spell/Trap Card, or another monster's effect, is
-- activated: Detach 1 Xyz Material from this card; negate the activation.
--[[ __CARD_HEADER_END__ ]]

--No.23 冥界の霊騎士ランスロット
function c66547759.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,8,2)
	c:EnableReviveLimit()
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c66547759.dacon)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(66547759,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCondition(c66547759.descon)
	e2:SetTarget(c66547759.destg)
	e2:SetOperation(c66547759.desop)
	c:RegisterEffect(e2)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(66547759,1))
	e3:SetCategory(CATEGORY_NEGATE)
	e3:SetType(EFFECT_TYPE_QUICK_F)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c66547759.discon)
	e3:SetCost(c66547759.discost)
	e3:SetTarget(c66547759.distg)
	e3:SetOperation(c66547759.disop)
	c:RegisterEffect(e3)
end
aux.xyz_number[66547759]=23
function c66547759.dacon(e)
	return e:GetHandler():GetOverlayCount()>0
end
function c66547759.descon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c66547759.filter(c)
	return c:IsFaceup()
end
function c66547759.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c66547759.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c66547759.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c66547759.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c66547759.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c66547759.discon(e,tp,eg,ep,ev,re,r,rp)
	return (re:IsHasType(EFFECT_TYPE_ACTIVATE) or re:IsActiveType(TYPE_MONSTER))
		and re:GetHandler()~=e:GetHandler()
end
function c66547759.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c66547759.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c66547759.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetCurrentChain()==ev+1 then
		Duel.NegateActivation(ev)
	end
end
