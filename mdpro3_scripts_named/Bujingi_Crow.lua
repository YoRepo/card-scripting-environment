--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 武神器-八咫  (ID: 89662736)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Winged Beast
-- Level 4
-- ATK 1700 | DEF 800
-- Setcode: 136
--
-- Effect Text:
-- 自己场上的名字带有「武神」的兽战士族怪兽被选择作为对方怪兽的攻击对象时，把这张卡从手卡送去墓地才能发动。攻击怪兽的攻击无效，给与对方基本分那只怪兽的攻击力一半数值的伤害。「武神器-八咫」的效果1回合只
-- 能使用1次。
--[[ __CARD_HEADER_END__ ]]

--武神器－ヤタ
function c89662736.initial_effect(c)
	--negate attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89662736,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,89662736)
	e1:SetCondition(c89662736.nacon)
	e1:SetCost(c89662736.nacost)
	e1:SetTarget(c89662736.natg)
	e1:SetOperation(c89662736.naop)
	c:RegisterEffect(e1)
end
function c89662736.nacon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return at:IsControler(tp) and at:IsFaceup() and at:IsSetCard(0x88) and at:IsRace(RACE_BEASTWARRIOR)
end
function c89662736.nacost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c89662736.natg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetAttacker():IsOnField() end
	local dam=math.floor(Duel.GetAttacker():GetAttack()/2)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c89662736.naop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if Duel.NegateAttack() then
		Duel.Damage(1-tp,math.floor(a:GetAttack()/2),REASON_EFFECT)
	end
end
