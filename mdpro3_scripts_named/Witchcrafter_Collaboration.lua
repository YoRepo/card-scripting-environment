--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 魔女术的合作  (ID: 10805153)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 296
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：以自己场上1只「魔女术」怪兽为对象才能发动。这个回合，那只怪兽在同1次的战斗阶段中可以作2次攻击，那只怪兽攻击的场合，对方直到伤害步骤结束时魔法·陷阱卡不能发动。
-- ②：这张卡在墓地存在，自己场上有「魔女术」怪兽存在的场合，自己结束阶段才能发动。这张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ウィッチクラフト・コラボレーション
function c10805153.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,10805153)
	e1:SetTarget(c10805153.target)
	e1:SetOperation(c10805153.activate)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10805153,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1,10805153)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c10805153.thcon)
	e2:SetTarget(c10805153.thtg)
	e2:SetOperation(c10805153.thop)
	c:RegisterEffect(e2)
end
function c10805153.filter(c)
	return c:IsSetCard(0x128) and c:IsFaceup() and not c:IsHasEffect(EFFECT_EXTRA_ATTACK)
end
function c10805153.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc,exc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c10805153.filter(chkc) end
	if chk==0 then return aux.bpcon(e,tp,eg,ep,ev,re,r,rp)
		and Duel.IsExistingTarget(c10805153.filter,tp,LOCATION_MZONE,0,1,exc) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c10805153.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c10805153.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		--extra attack
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		--actlimit
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e2:SetCode(EFFECT_CANNOT_ACTIVATE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetTargetRange(0,1)
		e2:SetValue(c10805153.aclimit)
		e2:SetCondition(c10805153.actcon)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
	end
end
function c10805153.aclimit(e,re,tp)
	return re:GetHandler():IsType(TYPE_SPELL+TYPE_TRAP) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c10805153.actcon(e)
	return Duel.GetAttacker()==e:GetHandler()
end
function c10805153.rccfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x128)
end
function c10805153.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
		and Duel.IsExistingMatchingCard(c10805153.rccfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c10805153.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c10805153.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
end
