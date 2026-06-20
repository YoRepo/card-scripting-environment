--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 影六武众-玄蕃  (ID: 7291576)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Warrior
-- Level 2
-- ATK 500 | DEF 2100
-- Setcode: 36925
--
-- Effect Text:
-- ①：这张卡召唤成功时，以除外的1只自己的「六武众」怪兽为对象才能发动。那只怪兽加入手卡。
-- ②：只让自己场上的「六武众」怪兽1只被效果破坏的场合，可以作为代替把墓地的这张卡除外。
--[[ __CARD_HEADER_END__ ]]

--影六武衆－ゲンバ
function c7291576.initial_effect(c)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(7291576,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c7291576.thtg)
	e1:SetOperation(c7291576.thop)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetTarget(c7291576.reptg)
	e2:SetValue(c7291576.repval)
	e2:SetOperation(c7291576.repop)
	c:RegisterEffect(e2)
end
function c7291576.thfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x103d) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c7291576.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_REMOVED) and c7291576.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c7291576.thfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c7291576.thfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c7291576.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
function c7291576.repfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x103d)
		and c:IsLocation(LOCATION_MZONE) and c:IsControler(tp) and c:IsReason(REASON_EFFECT) and not c:IsReason(REASON_REPLACE)
end
function c7291576.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and eg:IsExists(c7291576.repfilter,1,nil,tp)
		and eg:GetCount()==1 end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c7291576.repval(e,c)
	return c7291576.repfilter(c,e:GetHandlerPlayer())
end
function c7291576.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end
