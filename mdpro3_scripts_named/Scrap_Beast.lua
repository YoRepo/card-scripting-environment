--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 废铁兽  (ID: 19139516)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Beast
-- Level 4
-- ATK 1600 | DEF 1300
-- Setcode: 36
--
-- Effect Text:
-- 场上表侧守备表示存在的这张卡被选择作为攻击对象的场合，战斗阶段结束时这张卡破坏。这张卡被名字带有「废铁」的卡的效果破坏送去墓地的场合，可以选择「废铁兽」以外的自己墓地存在的1只名字带有「废铁」的怪兽加
-- 入手卡。
--[[ __CARD_HEADER_END__ ]]

--スクラップ・ビースト
function c19139516.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetOperation(c19139516.regop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(19139516,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e2:SetCountLimit(1)
	e2:SetTarget(c19139516.destg)
	e2:SetOperation(c19139516.desop)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(19139516,1))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCondition(c19139516.thcon)
	e3:SetTarget(c19139516.thtg)
	e3:SetOperation(c19139516.thop)
	c:RegisterEffect(e3)
end
function c19139516.regop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsDefensePos() and e:GetHandler():IsFaceup() then
		e:GetHandler():RegisterFlagEffect(19139516,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE,0,1)
	end
end
function c19139516.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(19139516)~=0 end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c19139516.desop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
function c19139516.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return bit.band(c:GetReason(),0x41)==0x41 and re:GetOwner():IsSetCard(0x24)
end
function c19139516.filter(c)
	return c:IsSetCard(0x24) and c:IsType(TYPE_MONSTER) and not c:IsCode(19139516) and c:IsAbleToHand()
end
function c19139516.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c19139516.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c19139516.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c19139516.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c19139516.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
