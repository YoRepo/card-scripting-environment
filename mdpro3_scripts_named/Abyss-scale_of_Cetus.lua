--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 深渊鳞甲-鲸鱼  (ID: 19596712)
-- Type: Spell / Field
-- ATK 0 | DEF 0
-- Setcode: 117
--
-- Effect Text:
-- 名字带有「水精鳞」的怪兽才能装备。装备怪兽的攻击力上升800。只要这张卡在场上存在，对方场上发动的陷阱卡的效果无效。那之后，这张卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--アビスケイル－ケートス
function c19596712.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CONTINUOUS_TARGET)
	e1:SetTarget(c19596712.target)
	e1:SetOperation(c19596712.operation)
	c:RegisterEffect(e1)
	--Atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(800)
	c:RegisterEffect(e2)
	--Equip limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EQUIP_LIMIT)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetValue(c19596712.eqlimit)
	c:RegisterEffect(e3)
	--negate
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_CHAIN_SOLVING)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c19596712.negcon)
	e4:SetOperation(c19596712.negop)
	c:RegisterEffect(e4)
end
function c19596712.eqlimit(e,c)
	return c:IsSetCard(0x74)
end
function c19596712.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x74)
end
function c19596712.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c19596712.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c19596712.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c19596712.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c19596712.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c19596712.negcon(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)==LOCATION_SZONE
		and re:IsActiveType(TYPE_TRAP) and Duel.IsChainDisablable(ev)
end
function c19596712.negop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateEffect(ev,true) then
		Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
	end
end
