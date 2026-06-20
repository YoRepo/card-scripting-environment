--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 神圣标枪  (ID: 96355986)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方怪兽的攻击宣言时才能发动。自己基本分回复那1只攻击怪兽的攻击力的数值。
--[[ __CARD_HEADER_END__ ]]

--ホーリージャベリン
function c96355986.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c96355986.condition)
	e1:SetTarget(c96355986.target)
	e1:SetOperation(c96355986.activate)
	c:RegisterEffect(e1)
end
function c96355986.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c96355986.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
	local rec=tg:GetAttack()
	Duel.SetTargetParam(rec)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,rec)
end
function c96355986.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local rec=tc:GetAttack()
		Duel.Recover(tp,rec,REASON_EFFECT)
	end
end
