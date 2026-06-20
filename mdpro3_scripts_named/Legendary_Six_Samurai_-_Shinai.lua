--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 真六武众-竹刀  (ID: 48505422)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Warrior
-- Level 3
-- ATK 1500 | DEF 1500
-- Setcode: 4157
--
-- Effect Text:
-- 自己场上有「真六武众-瑞穂」表侧表示存在的场合，这张卡可以从手卡特殊召唤。场上存在的这张卡被解放的场合，选择自己墓地存在的「真六武众-竹刀」以外的1只名字带有「六武众」的怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--真六武衆－シナイ
function c48505422.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c48505422.spcon)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(48505422,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_RELEASE)
	e2:SetCondition(c48505422.rlcon)
	e2:SetTarget(c48505422.rltg)
	e2:SetOperation(c48505422.rlop)
	c:RegisterEffect(e2)
end
function c48505422.spfilter(c)
	return c:IsFaceup() and c:IsCode(74094021)
end
function c48505422.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c48505422.spfilter,c:GetControler(),LOCATION_ONFIELD,0,1,nil)
end
function c48505422.rlcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c48505422.filter(c)
	return c:IsSetCard(0x103d) and not c:IsCode(48505422) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c48505422.rltg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c48505422.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c48505422.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c48505422.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c48505422.rlop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
