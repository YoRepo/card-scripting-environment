--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 连神龙  (ID: 10669138)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Dragon
-- ATK 5000 | LINK
--
-- Effect Text:
-- 怪兽5只
-- 这张卡不用连接召唤不能特殊召唤。
-- ①：这张卡用暗·地·水·炎·风属性全部为素材作连接召唤成功的场合才能发动。对方场上的卡全部破坏。
-- ②：场上的这张卡不受其他卡的效果影响，不会被和暗·地·水·炎·风属性怪兽的战斗破坏。
-- ③：对方结束阶段发动。从自己墓地选5张卡里侧表示除外。不能让5张除外的场合，这张卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--L・G・D
function c10669138.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,nil,5,5)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.linklimit)
	c:RegisterEffect(e1)
	--mat check
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(c10669138.matcheck)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(10669138,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCondition(c10669138.descon)
	e3:SetTarget(c10669138.destg)
	e3:SetOperation(c10669138.desop)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
	--immume
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_IMMUNE_EFFECT)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(c10669138.efilter)
	c:RegisterEffect(e4)
	--indes battle
	local e5=e4:Clone()
	e5:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e5:SetValue(c10669138.indes)
	c:RegisterEffect(e5)
	--remove
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(10669138,1))
	e6:SetCategory(CATEGORY_REMOVE+CATEGORY_TOGRAVE)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_PHASE+PHASE_END)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCountLimit(1)
	e6:SetCondition(c10669138.rmcon)
	e6:SetTarget(c10669138.rmtg)
	e6:SetOperation(c10669138.rmop)
	c:RegisterEffect(e6)
end
function c10669138.matcheck(e,c)
	local g=c:GetMaterial()
	local att=0
	local tc=g:GetFirst()
	while tc do
		att=att|tc:GetLinkAttribute()
		tc=g:GetNext()
	end
	e:SetLabel(att)
end
function c10669138.descon(e,tp,eg,ep,ev,re,r,rp)
	local att=e:GetLabelObject():GetLabel()
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK) and att&ATTRIBUTE_DARK>0
		and att&ATTRIBUTE_EARTH>0 and att&ATTRIBUTE_WATER>0
		and att&ATTRIBUTE_FIRE>0 and att&ATTRIBUTE_WIND>0
end
function c10669138.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c10669138.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
function c10669138.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c10669138.indes(e,c)
	return c:IsAttribute(ATTRIBUTE_DARK+ATTRIBUTE_EARTH+ATTRIBUTE_WATER+ATTRIBUTE_FIRE+ATTRIBUTE_WIND)
end
function c10669138.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==1-tp
end
function c10669138.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,5,tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,e:GetHandler(),1,0,0)
end
function c10669138.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local res=false
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_GRAVE,0,nil,tp,POS_FACEDOWN)
	if g:GetCount()>=5 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local sg=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_GRAVE,0,5,5,nil,tp,POS_FACEDOWN)
		Duel.Remove(sg,POS_FACEDOWN,REASON_EFFECT)
		if Duel.GetOperatedGroup():FilterCount(Card.IsLocation,nil,LOCATION_REMOVED)==5 then res=true end
	end
	if not res and c:IsRelateToEffect(e) then
		Duel.SendtoGrave(c,REASON_EFFECT)
	end
end
