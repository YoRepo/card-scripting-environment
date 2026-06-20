--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 鲜活水银 汞合兽  (ID: 22984000)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Aqua
-- Rank 10
-- ATK 3000 | DEF 3000
--
-- Effect Text:
-- 10星怪兽×2只以上
-- 这张卡超量召唤的场合：可以从卡组把1只怪兽作为这张卡的超量素材。「鲜活水银 汞合兽」的这个效果1回合只能使用1次。
-- 只要这张卡持有超量素材，对方不能把自身墓地的，和自己墓地的怪兽相同属性的怪兽的效果发动。
-- 1回合1次，结束阶段：这张卡1个超量素材取除或者自己受到3000伤害。
--[[ __CARD_HEADER_END__ ]]

--Mercurium the Living Quicksilver
local s,id,o=GetID()
function s.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,10,2,nil,nil,99)
	c:EnableReviveLimit()
	--material
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.mtcon)
	e1:SetTarget(s.mttg)
	e1:SetOperation(s.mtop)
	c:RegisterEffect(e1)
	--cannot activate
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,1)
	e2:SetCondition(s.limcon)
	e2:SetValue(s.limval)
	c:RegisterEffect(e2)
	--remove material
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(s.rmtg)
	e3:SetOperation(s.rmop)
	c:RegisterEffect(e3)
end
function s.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ)
end
function s.mtfilter(c,e)
	return c:IsType(TYPE_MONSTER)
		and c:IsCanOverlay() and not (e and c:IsImmuneToEffect(e))
end
function s.mttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsType(TYPE_XYZ)
		and Duel.IsExistingMatchingCard(s.mtfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function s.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToChain() then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectMatchingCard(tp,s.mtfilter,tp,LOCATION_DECK,0,1,1,nil,e)
	if g:GetCount()>0 then
		Duel.Overlay(c,g)
	end
end
function s.cfilter(c,ec)
	return c:IsAttribute(ec:GetAttribute())
end
function s.limcon(e)
	return e:GetHandler():GetOverlayCount()>0
end
function s.limval(e,re,rp)
	local rc=re:GetHandler()
	return rc:IsLocation(LOCATION_GRAVE) and re:IsActiveType(TYPE_MONSTER)
		and Duel.IsExistingMatchingCard(s.cfilter,e:GetHandlerPlayer(),LOCATION_GRAVE,0,1,nil,rc)
end
function s.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if e:GetHandler():GetOverlayCount()==0 then
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,3000)
	end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function s.rmop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_EFFECT) and Duel.SelectYesNo(tp,aux.Stringid(id,2)) then
		e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_EFFECT)
	else
		Duel.Damage(tp,3000,REASON_EFFECT)
	end
end
