--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 穿刺的落穴  (ID: 75902998)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 76
--
-- Effect Text:
-- ①：这个回合召唤·特殊召唤的对方怪兽的攻击宣言时才能发动。那只攻击怪兽破坏，给与对方那只怪兽的原本攻击力一半数值的伤害。
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
