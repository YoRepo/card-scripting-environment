--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 捕食植物 奇美拉大花草  (ID: 25586143)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Plant
-- Level 7
-- ATK 2500 | DEF 2000
-- Setcode: 4339
--
-- Effect Text:
-- 「捕食植物」怪兽＋暗属性怪兽
-- ①：1回合1次，以持有这张卡的等级以下的等级的场上1只怪兽为对象才能发动。那只怪兽除外。
-- ②：这张卡和对方的表侧表示怪兽进行战斗的攻击宣言时才能发动。直到回合结束时，那只对方怪兽的攻击力下降1000，这张卡的攻击力上升1000。
-- ③：这张卡被送去墓地的场合，下次的准备阶段才能发动。从卡组把1张「融合」魔法卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--捕食植物キメラフレシア
function c25586143.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x10f3),aux.FilterBoolFunction(Card.IsFusionAttribute,ATTRIBUTE_DARK),true)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(25586143,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c25586143.rmtg)
	e1:SetOperation(c25586143.rmop)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(25586143,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c25586143.atkcon)
	e2:SetTarget(c25586143.atktg)
	e2:SetOperation(c25586143.atkop)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetOperation(c25586143.regop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(25586143,2))
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCountLimit(1)
	e4:SetCondition(c25586143.thcon)
	e4:SetTarget(c25586143.thtg)
	e4:SetOperation(c25586143.thop)
	c:RegisterEffect(e4)
end
function c25586143.rmfilter(c,lv)
	return c:IsFaceup() and c:IsLevelBelow(lv) and c:IsAbleToRemove()
end
function c25586143.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c25586143.rmfilter(chkc,c:GetLevel()) end
	if chk==0 then return Duel.IsExistingTarget(c25586143.rmfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,c:GetLevel()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c25586143.rmfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,c:GetLevel())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c25586143.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
function c25586143.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	e:SetLabelObject(tc)
	return tc and tc:IsFaceup()
end
function c25586143.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:GetLabelObject():CreateEffectRelation(e)
end
function c25586143.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=e:GetLabelObject()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsControler(1-tp) and not tc:IsImmuneToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-1000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		if c:IsRelateToEffect(e) and c:IsFaceup() and not tc:IsHasEffect(EFFECT_REVERSE_UPDATE) then
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetValue(1000)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			c:RegisterEffect(e2)
		end
	end
end
function c25586143.regop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetCurrentPhase()==PHASE_STANDBY then
		e:GetHandler():RegisterFlagEffect(25586143,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_STANDBY,0,2,Duel.GetTurnCount())
	else
		e:GetHandler():RegisterFlagEffect(25586143,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_STANDBY,0,1,0)
	end
end
function c25586143.thcon(e,tp,eg,ep,ev,re,r,rp)
	local tid=e:GetHandler():GetFlagEffectLabel(25586143)
	return tid and tid~=Duel.GetTurnCount()
end
function c25586143.thfilter(c)
	return c:IsSetCard(0x46) and c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c25586143.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c25586143.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c25586143.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c25586143.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
