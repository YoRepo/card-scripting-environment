--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 废铁士兵  (ID: 65503206)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Warrior
-- Level 5
-- ATK 2100 | DEF 700
-- Setcode: 36
--
-- Effect Text:
-- 场上表侧守备表示存在的这张卡被选择作为攻击对象的场合，战斗阶段结束时这张卡破坏。这张卡被名字带有「废铁」的卡的效果破坏送去墓地的场合，可以选择「废铁士兵」以外的自己墓地存在的1只名字带有「废铁」的怪兽
-- 加入手卡。把这张卡作为同调素材的场合，不是名字带有「废铁」的怪兽的同调召唤不能使用。
--[[ __CARD_HEADER_END__ ]]

--スクラップ・ソルジャー
function c65503206.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetOperation(c65503206.regop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(65503206,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e2:SetCountLimit(1)
	e2:SetTarget(c65503206.destg)
	e2:SetOperation(c65503206.desop)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(65503206,1))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e3:SetCondition(c65503206.thcon)
	e3:SetTarget(c65503206.thtg)
	e3:SetOperation(c65503206.thop)
	c:RegisterEffect(e3)
	--synchro limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetValue(c65503206.synlimit)
	c:RegisterEffect(e2)
end
function c65503206.regop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsDefensePos() and e:GetHandler():IsFaceup() then
		e:GetHandler():RegisterFlagEffect(65503206,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE,0,1)
	end
end
function c65503206.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(65503206)~=0 end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c65503206.desop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
function c65503206.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return bit.band(c:GetReason(),0x41)==0x41 and re:GetOwner():IsSetCard(0x24)
end
function c65503206.filter(c)
	return c:IsSetCard(0x24) and c:IsType(TYPE_MONSTER) and not c:IsCode(65503206) and c:IsAbleToHand()
end
function c65503206.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c65503206.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c65503206.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c65503206.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c65503206.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
function c65503206.synlimit(e,c)
	if not c then return false end
	return not c:IsSetCard(0x24)
end
