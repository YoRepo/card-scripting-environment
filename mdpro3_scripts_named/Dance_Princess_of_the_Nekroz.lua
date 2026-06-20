--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 影灵衣舞姬  (ID: 52738610)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Spellcaster
-- Level 4
-- ATK 1600 | DEF 800
-- Setcode: 180
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：只要这张卡在怪兽区域存在，对方不能对应「影灵衣」仪式魔法卡的发动把魔法·陷阱·怪兽的效果发动，对方不能把自己场上的「影灵衣」仪式怪兽作为效果的对象。
-- ②：这张卡被效果解放的场合，以「影灵衣舞姬」以外的自己的除外状态的1只「影灵衣」怪兽为对象才能发动。那只怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--影霊衣の舞姫
function c52738610.initial_effect(c)
	--act limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c52738610.chainop)
	c:RegisterEffect(e1)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c52738610.tgtg)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_RELEASE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1,52738610)
	e3:SetCondition(c52738610.thcon)
	e3:SetTarget(c52738610.thtg)
	e3:SetOperation(c52738610.thop)
	c:RegisterEffect(e3)
end
function c52738610.chainop(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	if re:IsHasType(EFFECT_TYPE_ACTIVATE) and rc:IsSetCard(0xb4) and re:IsActiveType(TYPE_RITUAL) then
		Duel.SetChainLimit(c52738610.chainlm)
	end
end
function c52738610.chainlm(e,rp,tp)
	return tp==rp
end
function c52738610.tgtg(e,c)
	return c:IsSetCard(0xb4) and c:IsType(TYPE_RITUAL)
end
function c52738610.thcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0
end
function c52738610.thfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xb4) and c:IsType(TYPE_MONSTER) and not c:IsCode(52738610) and c:IsAbleToHand()
end
function c52738610.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c52738610.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c52738610.thfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c52738610.thfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c52738610.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
