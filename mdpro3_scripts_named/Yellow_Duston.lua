--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 黄尘妖  (ID: 16366810)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fiend
-- Level 1
-- ATK 0 | DEF 1000
-- Setcode: 128
--
-- Effect Text:
-- 这张卡不能解放，也不能作为融合·同调·超量召唤的素材。场上的这张卡被破坏时，这张卡的控制者选择自己墓地1只怪兽回到卡组。「黄尘妖」在自己场上只能有1只表侧表示存在。
--[[ __CARD_HEADER_END__ ]]

--イエロー・ダストン
function c16366810.initial_effect(c)
	c:SetUniqueOnField(1,0,16366810)
	--cannot release
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UNRELEASABLE_SUM)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e3:SetValue(c16366810.fuslimit)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	c:RegisterEffect(e5)
	--todeck
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(16366810,0))
	e6:SetCategory(CATEGORY_TODECK)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e6:SetCode(EVENT_DESTROYED)
	e6:SetCondition(c16366810.retcon)
	e6:SetTarget(c16366810.rettg)
	e6:SetOperation(c16366810.retop)
	c:RegisterEffect(e6)
end
function c16366810.fuslimit(e,c,sumtype)
	return sumtype==SUMMON_TYPE_FUSION
end
function c16366810.retcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_DESTROY) and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c16366810.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToDeck()
end
function c16366810.rettg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local prec=e:GetHandler():GetPreviousControler()
	if chkc then return chkc:IsControler(prec) and chkc:IsLocation(LOCATION_GRAVE) and c16366810.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(prec,c16366810.filter,prec,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c16366810.retop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
