--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 天猪福  (ID: 83991690)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Fairy
-- Level 1
-- ATK 200 | DEF 300
--
-- Effect Text:
-- 自己的主要阶段时，把墓地存在的这张卡从游戏中除外，选择自己场上表侧表示存在的1只4星以下的天使族·光属性怪兽才能发动。选择的怪兽只要在场上表侧表示存在当作调整使用。
--[[ __CARD_HEADER_END__ ]]

--ブーテン
function c83991690.initial_effect(c)
	--tuner
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(83991690,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c83991690.target)
	e1:SetOperation(c83991690.operation)
	c:RegisterEffect(e1)
end
function c83991690.filter(c)
	return c:IsFaceup() and c:IsLevelBelow(4) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_FAIRY) and not c:IsType(TYPE_TUNER)
end
function c83991690.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c83991690.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c83991690.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c83991690.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c83991690.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_ADD_TYPE)
		e1:SetValue(TYPE_TUNER)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
