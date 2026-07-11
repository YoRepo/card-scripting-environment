--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Sonic Shooter  (ID: 40384720)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level: 4
-- ATK 1300 | DEF 600
-- Scope: OCG / TCG
--
-- Effect Text:
-- If there are no cards in your opponent's Spell & Trap Zone, this card can attack your opponent
-- directly.
-- If it does, the battle damage inflicted to your opponent is the original ATK of this card.
--[[ __CARD_HEADER_END__ ]]

--ソニック・シューター
function c40384720.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c40384720.dircon)
	c:RegisterEffect(e1)
	--damage reduce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e2:SetCondition(c40384720.rdcon)
	e2:SetValue(c40384720.rdval)
	c:RegisterEffect(e2)
end
function c40384720.dfilter(c)
	return c:GetSequence()<5
end
function c40384720.dircon(e)
	return not Duel.IsExistingMatchingCard(c40384720.dfilter,e:GetHandlerPlayer(),0,LOCATION_SZONE,1,nil)
end
function c40384720.rdcon(e)
	local c=e:GetHandler()
	local tp=e:GetHandlerPlayer()
	return Duel.GetAttackTarget()==nil
		and c:GetEffectCount(EFFECT_DIRECT_ATTACK)<2 and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
end
function c40384720.rdval(e,damp)
	if damp==1-e:GetHandlerPlayer() then
		return e:GetHandler():GetBaseAttack()
	else return -1 end
end
