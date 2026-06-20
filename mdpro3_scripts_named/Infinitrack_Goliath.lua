--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 无限起动 哥利亚巨人  (ID: 23689428)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Machine
-- ATK 1000 | LINK
-- Setcode: 295
--
-- Effect Text:
-- 连接怪兽以外的「无限起动」怪兽1只
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡从场上送去墓地的场合，以自己场上1只超量怪兽为对象才能发动。把这张卡在那只怪兽下面重叠作为超量素材。
-- ②：持有这张卡作为素材中的原本种族是机械族的超量怪兽得到以下效果。
-- ●这张卡不会被效果破坏。
--[[ __CARD_HEADER_END__ ]]

--無限起動ゴライアス
function c23689428.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,c23689428.matfilter,1,1)
	c:EnableReviveLimit()
	--Attach
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23689428,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCountLimit(1,23689428)
	e1:SetCondition(c23689428.xyzcon)
	e1:SetTarget(c23689428.xyztg)
	e1:SetOperation(c23689428.xyzop)
	c:RegisterEffect(e1)
	--get effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_XMATERIAL)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetCondition(c23689428.condition)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c23689428.matfilter(c)
	return c:IsLinkSetCard(0x127) and not c:IsLinkType(TYPE_LINK)
end
function c23689428.xyzcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c23689428.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c23689428.xyztg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c23689428.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c23689428.filter,tp,LOCATION_MZONE,0,1,nil)
		and e:GetHandler():IsCanOverlay() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c23689428.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,e:GetHandler(),1,0,0)
end
function c23689428.xyzop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) and c:IsRelateToEffect(e) and c:IsCanOverlay() then
		Duel.Overlay(tc,Group.FromCards(c))
	end
end
function c23689428.condition(e)
	return e:GetHandler():GetOriginalRace()==RACE_MACHINE
end
