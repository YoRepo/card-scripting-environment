--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 机甲破坏预备兵  (ID: 54563536)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 4
-- ATK 1200 | DEF 1800
-- Setcode: 54
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：把手卡·场上的这张卡送去墓地，以自己场上1只「机甲」怪兽为对象才能发动。那只怪兽的攻击力直到回合结束时上升1200。这个效果在对方回合也能发动。
-- ②：这张卡在墓地存在，自己的「机甲」怪兽战斗破坏对方怪兽时才能发动。这张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--マシンナーズ・リザーブレイク
function c54563536.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(54563536,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(LOCATION_HAND+LOCATION_MZONE)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCountLimit(1,54563536)
	e1:SetCondition(aux.dscon)
	e1:SetCost(c54563536.atkcost)
	e1:SetTarget(c54563536.atktg)
	e1:SetOperation(c54563536.atkop)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(54563536,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,54563537)
	e2:SetCondition(c54563536.thcon)
	e2:SetTarget(c54563536.thtg)
	e2:SetOperation(c54563536.thop)
	c:RegisterEffect(e2)
end
function c54563536.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() end
	Duel.SendtoGrave(c,REASON_COST)
end
function c54563536.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x36)
end
function c54563536.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c54563536.atkfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c54563536.atkfilter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c54563536.atkfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c54563536.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(1200)
		tc:RegisterEffect(e1)
	end
end
function c54563536.thcon(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsContains(e:GetHandler()) then return false end
	local rc=eg:GetFirst()
	return rc:IsRelateToBattle() and rc:IsStatus(STATUS_OPPO_BATTLE)
		and rc:IsFaceup() and rc:IsSetCard(0x36) and rc:IsControler(tp)
end
function c54563536.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c54563536.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
end
