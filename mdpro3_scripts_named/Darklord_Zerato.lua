--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 堕天使 杰拉特  (ID: 40921744)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fairy
-- Level 8
-- ATK 2800 | DEF 2300
-- Setcode: 239
--
-- Effect Text:
-- 自己墓地有暗属性怪兽4种类以上存在的场合，这张卡可以把1只暗属性怪兽解放作上级召唤。
-- ①：从手卡把1只暗属性怪兽送去墓地才能发动。对方场上的怪兽全部破坏。
-- ②：这张卡的①的效果发动的回合的结束阶段发动。这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--堕天使ゼラート
function c40921744.initial_effect(c)
	--summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(40921744,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c40921744.sumcon)
	e1:SetOperation(c40921744.sumop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(40921744,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c40921744.descost)
	e2:SetTarget(c40921744.destg)
	e2:SetOperation(c40921744.desop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(40921744,2))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c40921744.sdescon)
	e3:SetTarget(c40921744.sdestg)
	e3:SetOperation(c40921744.sdesop)
	c:RegisterEffect(e3)
end
function c40921744.mfilter(c,tp)
	return c:IsAttribute(ATTRIBUTE_DARK) and (c:IsControler(tp) or c:IsFaceup())
end
function c40921744.sumcon(e,c,minc)
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=Duel.GetMatchingGroup(c40921744.mfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,tp)
	local ag=Duel.GetMatchingGroup(Card.IsAttribute,tp,LOCATION_GRAVE,0,nil,ATTRIBUTE_DARK)
	return c:IsLevelAbove(7) and minc<=1 and Duel.CheckTribute(c,1,1,mg)
		and ag:GetClassCount(Card.GetCode)>=4
end
function c40921744.sumop(e,tp,eg,ep,ev,re,r,rp,c)
	local mg=Duel.GetMatchingGroup(c40921744.mfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,tp)
	local sg=Duel.SelectTribute(tp,c,1,1,mg)
	c:SetMaterial(sg)
	Duel.Release(sg,REASON_SUMMON+REASON_MATERIAL)
end
function c40921744.cfilter(c)
	return c:IsAttribute(ATTRIBUTE_DARK) and c:IsAbleToGraveAsCost()
end
function c40921744.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c40921744.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c40921744.cfilter,1,1,REASON_COST)
	e:GetHandler():RegisterFlagEffect(40921744,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
end
function c40921744.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c40921744.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
function c40921744.sdescon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(40921744)~=0
end
function c40921744.sdestg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c40921744.sdesop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.Destroy(c,REASON_EFFECT)
	end
end
