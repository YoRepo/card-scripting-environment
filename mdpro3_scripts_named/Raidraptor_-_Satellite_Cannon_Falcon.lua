--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 急袭猛禽-卫星炮猎鹰  (ID: 23603403)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Winged Beast
-- Rank 8
-- ATK 3000 | DEF 2000
-- Setcode: 186
--
-- Effect Text:
-- 鸟兽族8星怪兽×2
-- ①：这张卡用「急袭猛禽」怪兽为素材作超量召唤成功的场合才能发动。对方场上的魔法·陷阱卡全部破坏。对方不能对应这个效果的发动把魔法·陷阱·怪兽的效果发动。
-- ②：把这张卡1个超量素材取除，以对方场上1只表侧表示怪兽为对象才能发动。那只怪兽的攻击力下降自己墓地的「急袭猛禽」怪兽数量×800。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--RR－サテライト・キャノン・ファルコン
function c23603403.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_WINDBEAST),8,2)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23603403,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c23603403.descon)
	e1:SetTarget(c23603403.destg)
	e1:SetOperation(c23603403.desop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(c23603403.valcheck)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(23603403,1))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(aux.dscon)
	e3:SetCost(c23603403.atkcost)
	e3:SetTarget(c23603403.atktg)
	e3:SetOperation(c23603403.atkop)
	c:RegisterEffect(e3)
end
function c23603403.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ) and e:GetLabel()==1
end
function c23603403.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c23603403.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c23603403.desfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c23603403.desfilter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetChainLimit(c23603403.chainlm)
end
function c23603403.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c23603403.desfilter,tp,0,LOCATION_ONFIELD,nil)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
function c23603403.chainlm(e,rp,tp)
	return tp==rp
end
function c23603403.valcheck(e,c)
	local g=c:GetMaterial()
	if g:IsExists(Card.IsSetCard,1,nil,0xba) then
		e:GetLabelObject():SetLabel(1)
	else
		e:GetLabelObject():SetLabel(0)
	end
end
function c23603403.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c23603403.atkfilter(c)
	return c:IsSetCard(0xba) and c:IsType(TYPE_MONSTER)
end
function c23603403.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingMatchingCard(c23603403.atkfilter,tp,LOCATION_GRAVE,0,1,nil)
		and Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
end
function c23603403.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local ct=Duel.GetMatchingGroupCount(c23603403.atkfilter,tp,LOCATION_GRAVE,0,nil)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(ct*-800)
		tc:RegisterEffect(e1)
	end
end
