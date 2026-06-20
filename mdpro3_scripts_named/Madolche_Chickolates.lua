--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 魔偶甜点·巧克力雏鸟  (ID: 26570480)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 3
-- ATK 800 | DEF 1500
-- Setcode: 113
--
-- Effect Text:
-- 这张卡被对方破坏送去墓地时，这张卡回到卡组。此外，1回合1次，这张卡在场上表侧表示存在，自己场上的名字带有「魔偶甜点」的怪兽的表示形式变更时才能发动。选择场上1只怪兽变成表侧守备表示，那只怪兽是名字带
-- 有「魔偶甜点」的怪兽以外的场合，那只怪兽不能攻击，效果无效化。
--[[ __CARD_HEADER_END__ ]]

--マドルチェ・ピョコレート
function c26570480.initial_effect(c)
	--to deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(26570480,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c26570480.retcon)
	e1:SetTarget(c26570480.rettg)
	e1:SetOperation(c26570480.retop)
	c:RegisterEffect(e1)
	--pos
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(26570480,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_CHANGE_POS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCondition(c26570480.poscon)
	e2:SetTarget(c26570480.postg)
	e2:SetOperation(c26570480.posop)
	c:RegisterEffect(e2)
end
function c26570480.retcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY) and e:GetHandler():GetReasonPlayer()==1-tp
		and e:GetHandler():IsPreviousControler(tp)
end
function c26570480.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c26570480.retop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoDeck(e:GetHandler(),nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
function c26570480.cfilter(c,tp,ec)
	local np=c:GetPosition()
	local pp=c:GetPreviousPosition()
	if c==ec then
		return ((np==POS_FACEUP_DEFENSE and pp==POS_FACEUP_ATTACK) or (np==POS_FACEUP_ATTACK and pp==POS_FACEUP_DEFENSE))
			and c:IsControler(tp) and c:IsSetCard(0x71)
	else
		return ((np==POS_FACEUP_DEFENSE and pp==POS_FACEUP_ATTACK) or (np==POS_FACEUP_ATTACK and pp&POS_DEFENSE~=0))
			and c:IsControler(tp) and c:IsSetCard(0x71)
	end
end
function c26570480.poscon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c26570480.cfilter,1,nil,tp,e:GetHandler())
end
function c26570480.filter(c)
	return not c:IsPosition(POS_FACEUP_DEFENSE) and c:IsCanChangePosition()
end
function c26570480.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c26570480.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c26570480.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	Duel.SelectTarget(tp,c26570480.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c26570480.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and not tc:IsPosition(POS_FACEUP_DEFENSE) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)
		if not tc:IsSetCard(0x71) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_ATTACK)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e2)
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_DISABLE_EFFECT)
			e3:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e3)
		end
	end
end
