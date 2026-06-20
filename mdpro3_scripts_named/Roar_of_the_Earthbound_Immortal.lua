--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 地缚神的咆哮  (ID: 56339050)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 4129
--
-- Effect Text:
-- 对方怪兽的攻击宣言时，攻击怪兽的攻击力比自己场上表侧表示存在的名字带有「地缚神」的怪兽的攻击力低的场合，把那1只攻击怪兽破坏，给与对方基本分破坏怪兽的攻击力一半数值的伤害。这个效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--地縛神の咆哮
function c56339050.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(56339050,0))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCountLimit(1)
	e2:SetCondition(c56339050.condition)
	e2:SetTarget(c56339050.target)
	e2:SetOperation(c56339050.operation)
	c:RegisterEffect(e2)
end
function c56339050.cfilter(c,atk)
	return c:IsFaceup() and c:IsSetCard(0x1021) and c:GetAttack()>atk
end
function c56339050.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return Duel.GetTurnPlayer()~=tp and Duel.IsExistingMatchingCard(c56339050.cfilter,tp,LOCATION_MZONE,0,1,nil,tc:GetAttack())
end
function c56339050.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=Duel.GetAttacker()
	if chkc then return chkc==tc end
	if chk==0 then return tc:IsOnField() and tc:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tc)
	local dam=math.floor(tc:GetAttack()/2)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c56339050.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsAttackable() then
		local atk=math.floor(tc:GetAttack()/2)
		if Duel.Destroy(tc,REASON_EFFECT)~=0 then
			Duel.Damage(1-tp,atk,REASON_EFFECT)
		end
	end
end
