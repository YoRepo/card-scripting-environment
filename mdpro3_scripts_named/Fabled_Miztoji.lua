--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 魔轰神 米兹托西  (ID: 8316661)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Fiend
-- Level 2
-- ATK 400 | DEF 200
-- Setcode: 53
--
-- Effect Text:
-- 把这张卡从手卡送去墓地，选择自己场上表侧表示存在的1只名字带有「魔轰神」的怪兽发动。选择怪兽只要在场上表侧表示存在当作调整使用。
--[[ __CARD_HEADER_END__ ]]

--魔轟神ミーズトージ
function c8316661.initial_effect(c)
	--change type
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(8316661,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c8316661.cost)
	e1:SetTarget(c8316661.tg)
	e1:SetOperation(c8316661.op)
	c:RegisterEffect(e1)
end
function c8316661.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c8316661.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x35) and not c:IsType(TYPE_TUNER)
end
function c8316661.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c8316661.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c8316661.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c8316661.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c8316661.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_ADD_TYPE)
		e1:SetValue(TYPE_TUNER)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
