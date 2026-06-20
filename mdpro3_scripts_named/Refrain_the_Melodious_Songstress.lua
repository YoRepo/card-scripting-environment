--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 幻奏的歌姬 勒弗兰  (ID: 64881644)
-- Type: Monster / Effect / Pendulum
-- Attribute: LIGHT
-- Race: Fairy
-- Level 4
-- Pendulum Scales: L1 / R1
-- ATK 1600 | DEF 800
-- Setcode: 155
--
-- Effect Text:
-- ←1 【灵摆】 1→
-- 这个卡名的灵摆效果1回合只能使用1次。
-- ①：以自己场上1只「幻奏」融合怪兽为对象才能发动。从卡组把1只「幻奏」怪兽送去墓地，作为对象的怪兽的攻击力直到回合结束时上升送去墓地的怪兽的等级×200。
-- 【怪兽效果】
-- 这个卡名的①②的怪兽效果1回合各能使用1次。
-- ①：这张卡召唤·特殊召唤的场合才能发动。从卡组把「幻奏的歌姬 勒弗兰」以外的1只「幻奏」怪兽加入手卡。
-- ②：这张卡在额外卡组表侧存在的状态，自己场上有「幻奏」融合怪兽特殊召唤的场合才能发动。这张卡在自己的灵摆区域放置。
--[[ __CARD_HEADER_END__ ]]

--幻奏の歌姫ルフラン
function c64881644.initial_effect(c)
	aux.EnablePendulumAttribute(c)
	--
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(64881644,0))
	e0:SetCategory(CATEGORY_ATKCHANGE)
	e0:SetType(EFFECT_TYPE_IGNITION)
	e0:SetRange(LOCATION_PZONE)
	e0:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e0:SetCountLimit(1,64881644)
	e0:SetTarget(c64881644.atktg)
	e0:SetOperation(c64881644.atkop)
	c:RegisterEffect(e0)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(64881644,1))
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,64881645)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetTarget(c64881644.thtg)
	e1:SetOperation(c64881644.thop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(64881644,2))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_EXTRA)
	e3:SetCountLimit(1,64881646)
	e3:SetCondition(c64881644.pencon)
	e3:SetTarget(c64881644.pentg)
	e3:SetOperation(c64881644.penop)
	c:RegisterEffect(e3)
end
function c64881644.tgfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x9b) and c:IsAbleToGrave()
end
function c64881644.filter(c)
	return c:IsType(TYPE_FUSION) and c:IsSetCard(0x9b) and c:IsFaceup()
end
function c64881644.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c64881644.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c64881644.filter,tp,LOCATION_MZONE,0,1,nil) and Duel.IsExistingMatchingCard(c64881644.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c64881644.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c64881644.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tg=Duel.SelectMatchingCard(tp,c64881644.tgfilter,tp,LOCATION_DECK,0,1,1,nil):GetFirst()
	if tg and Duel.SendtoGrave(tg,REASON_COST)~=0 and tg:IsLocation(LOCATION_GRAVE) then
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToEffect(e) and tc:IsFaceup() then
			local e0=Effect.CreateEffect(c)
			e0:SetType(EFFECT_TYPE_SINGLE)
			e0:SetCode(EFFECT_UPDATE_ATTACK)
			e0:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			e0:SetValue(tg:GetLevel()*200)
			tc:RegisterEffect(e0)
		end
	end
end
function c64881644.thfilter(c)
	return not c:IsCode(64881644) and c:IsType(TYPE_MONSTER) and c:IsSetCard(0x9b) and c:IsAbleToHand()
end
function c64881644.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c64881644.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c64881644.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c64881644.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c64881644.cfilter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_FUSION) and c:IsSetCard(0x9b) and c:IsControler(tp)
end
function c64881644.pencon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsFaceup() and eg:IsExists(c64881644.cfilter,1,nil,tp)
end
function c64881644.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1) end
end
function c64881644.penop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and (Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1)) then
		Duel.MoveToField(c,tp,tp,LOCATION_PZONE,POS_FACEUP,true)
	end
end
