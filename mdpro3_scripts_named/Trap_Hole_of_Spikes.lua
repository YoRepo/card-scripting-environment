--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Trap Hole of Spikes  (ID: 75902998)
-- Type: Trap
-- Setcode: 0x4c
-- Scope: OCG / TCG
--
-- Effect Text:
-- When an opponent's monster that was Normal or Special Summoned this turn declares an attack: Destroy
-- that attacking monster, and if you do, inflict damage to your opponent equal to half the original
-- ATK of that monster.
--[[ __CARD_HEADER_END__ ]]

--串刺しの落とし穴
function c75902998.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c75902998.condition)
	e1:SetTarget(c75902998.target)
	e1:SetOperation(c75902998.activate)
	c:RegisterEffect(e1)
end
function c75902998.condition(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:IsControler(1-tp) and at:IsStatus(STATUS_SUMMON_TURN+STATUS_SPSUMMON_TURN)
end
function c75902998.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local at=Duel.GetAttacker()
	if chk==0 then return at:IsRelateToBattle() end
	local dam=math.max(math.floor(at:GetBaseAttack()/2),0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,at,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c75902998.activate(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	if at:IsRelateToBattle() and Duel.Destroy(at,REASON_EFFECT)~=0 then
		local atk=math.floor(at:GetBaseAttack()/2)
		if atk>0 then
			Duel.Damage(1-tp,atk,REASON_EFFECT)
		end
	end
end
