--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 反击准备  (ID: 4483989)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 每次对方玩家对表侧守备表示怪兽进行攻击宣言时，投掷硬币猜正反。
-- ●猜中的场合：被攻击的表侧守备表示怪兽变成攻击表示。
-- ●猜错的场合：这张卡的控制者受到攻击怪兽的攻击力超过攻击对象的怪兽的守备力的数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--反撃準備
function c4483989.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_START)
	e1:SetTarget(c4483989.atktg1)
	e1:SetOperation(c4483989.atkop)
	c:RegisterEffect(e1)
	--dice
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(4483989,0))
	e2:SetCategory(CATEGORY_COIN)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c4483989.atkcon)
	e2:SetTarget(c4483989.atktg2)
	e2:SetOperation(c4483989.atkop)
	c:RegisterEffect(e2)
end
function c4483989.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return tp~=Duel.GetTurnPlayer() and at and at:IsPosition(POS_FACEUP_DEFENSE)
end
function c4483989.atktg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:SetLabel(0)
	local at=Duel.GetAttackTarget()
	if Duel.CheckEvent(EVENT_ATTACK_ANNOUNCE) and tp~=Duel.GetTurnPlayer()
		and at and at:IsPosition(POS_FACEUP_DEFENSE) then
		e:SetLabel(1)
		Duel.GetAttacker():CreateEffectRelation(e)
		at:CreateEffectRelation(e)
		Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
	end
end
function c4483989.atktg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:SetLabel(1)
	Duel.GetAttacker():CreateEffectRelation(e)
	Duel.GetAttackTarget():CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c4483989.atkop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 or not e:GetHandler():IsRelateToEffect(e) then return end
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	if a:IsFaceup() and a:IsRelateToEffect(e) and at:IsFaceup() and at:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_COIN)
		local coin=Duel.AnnounceCoin(1-tp)
		local res=Duel.TossCoin(1-tp,1)
		if coin~=res then
			Duel.ChangePosition(at,POS_FACEUP_ATTACK)
		elseif a:GetAttack()>at:GetDefense() then
			Duel.Damage(tp,a:GetAttack()-at:GetDefense(),REASON_EFFECT)
		end
	end
end
