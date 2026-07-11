--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Worm Noble  (ID: 7700132)
-- Type: Monster / Effect / Flip
-- Attribute: LIGHT
-- Race: Reptile
-- Level: 6
-- ATK 1500 | DEF 2400
-- Setcode: 0x3e
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: If this card is flipped face-up by an opponent's monster's attack, inflict damage equal to
-- half the ATK of the attacking monster.
--[[ __CARD_HEADER_END__ ]]

--ワーム・ノーブル
function c7700132.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FLIP+EFFECT_TYPE_SINGLE)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTarget(c7700132.damtg)
	e1:SetOperation(c7700132.damop)
	c:RegisterEffect(e1)
end
function c7700132.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if Duel.GetCurrentPhase()==PHASE_DAMAGE and e:GetHandler()==Duel.GetAttackTarget() then
		Duel.SetTargetPlayer(1-tp)
		Duel.SetTargetParam(math.floor(Duel.GetAttacker():GetAttack()/2))
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,math.floor(Duel.GetAttacker():GetAttack()/2))
	end
end
function c7700132.damop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetCurrentPhase()==PHASE_DAMAGE and e:GetHandler()==Duel.GetAttackTarget() then
		local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
		Duel.Damage(p,d,REASON_EFFECT)
	end
end
