--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 有勇无谋  (ID: 85709845)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上守备表示存在的怪兽成为攻击对象时才能发动。那只守备表示怪兽的表示形式变更为表侧攻击表示。并且，那次战斗破坏攻击怪兽送去墓地时，再给与对方基本分那只怪兽的原本攻击力数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--ガムシャラ
function c85709845.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetTarget(c85709845.target)
	e1:SetOperation(c85709845.activate)
	c:RegisterEffect(e1)
end
function c85709845.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local d=Duel.GetAttackTarget()
	if chk==0 then return d:IsDefensePos() and d:IsControler(tp) end
	Duel.SetTargetCard(d)
end
function c85709845.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsDefensePos() then
		Duel.ChangePosition(tc,POS_FACEUP_ATTACK)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(85709845,0))
		e1:SetCategory(CATEGORY_DAMAGE)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e1:SetCode(EVENT_BATTLE_DESTROYED)
		e1:SetCondition(c85709845.damcon)
		e1:SetTarget(c85709845.damtg)
		e1:SetOperation(c85709845.damop)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		Duel.RegisterEffect(e1,tp)
	end
end
function c85709845.damcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return eg:IsContains(tc) and tc:IsLocation(LOCATION_GRAVE) and tc:IsReason(REASON_BATTLE)
end
function c85709845.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local atk=Duel.GetAttacker():GetBaseAttack()
	if atk<0 then atk=0 end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(atk)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,atk)
end
function c85709845.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
