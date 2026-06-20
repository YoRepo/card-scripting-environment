--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 阿尔法大日  (ID: 56768355)
-- Type: Monster / Effect / Synchro
-- Attribute: LIGHT
-- Race: Machine
-- Level 9
-- ATK 2200 | DEF 1100
-- Setcode: 48
--
-- Effect Text:
-- 名字带有「大日」的调整＋调整以外的怪兽1只以上
-- 这张卡同调召唤成功时，可以选择自己墓地存在的1张装备魔法卡给这张卡装备。有装备卡装备的这张卡不会被装备卡以外的魔法·陷阱卡的效果破坏。
--[[ __CARD_HEADER_END__ ]]

--ヴァイロン・アルファ
function c56768355.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x30),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(56768355,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c56768355.eqcon)
	e1:SetTarget(c56768355.eqtg)
	e1:SetOperation(c56768355.eqop)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetCondition(c56768355.indcon)
	e2:SetValue(c56768355.indval)
	c:RegisterEffect(e2)
end
function c56768355.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c56768355.filter(c,ec)
	return c:IsType(TYPE_EQUIP) and c:CheckEquipTarget(ec)
end
function c56768355.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c56768355.filter(chkc,e:GetHandler()) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c56768355.filter,tp,LOCATION_GRAVE,0,1,nil,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c56768355.filter,tp,LOCATION_GRAVE,0,1,1,nil,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
end
function c56768355.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Equip(tp,tc,c)
	end
end
function c56768355.indcon(e)
	return e:GetHandler():GetEquipCount()>0
end
function c56768355.indval(e,re)
	if not re then return false end
	local ty=re:GetActiveType()
	return bit.band(ty,TYPE_SPELL+TYPE_TRAP)~=0 and bit.band(ty,TYPE_EQUIP)==0
end
