--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 同盟骑手  (ID: 11743119)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Machine
-- Level 2
-- ATK 1000 | DEF 1000
--
-- Effect Text:
-- 得到对方场上1张处于怪兽状态的同盟怪兽的控制权，装备在这张卡身上。这张卡至多只能以这种方式装备1只同盟怪兽。装备在这张卡身上的同盟怪兽不能以自身效果回复成怪兽状态。
--[[ __CARD_HEADER_END__ ]]

--ユニオン・ライダー
function c11743119.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11743119,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c11743119.eqcon)
	e1:SetTarget(c11743119.eqtg)
	e1:SetOperation(c11743119.eqop)
	c:RegisterEffect(e1)
end
c11743119.has_text_type=TYPE_UNION
function c11743119.eqcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=e:GetLabelObject()
	return ec==nil or ec:GetFlagEffect(11743119)==0
end
function c11743119.filter(c)
	return c:IsType(TYPE_UNION) and c:IsAbleToChangeControler()
end
function c11743119.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c11743119.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c11743119.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c11743119.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c11743119.eqlimit(e,c)
	return e:GetOwner()==c
end
function c11743119.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		if not Duel.Equip(tp,tc,c,false) then return end
		--Add Equip limit
		tc:RegisterFlagEffect(11743119,RESET_EVENT+RESETS_STANDARD,0,0)
		e:SetLabelObject(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(c11743119.eqlimit)
		tc:RegisterEffect(e1)
	end
end
