--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 俱舍怒威族·阿莱斯哈特  (ID: 48626373)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Machine
-- Rank 7
-- ATK 3000 | DEF 3000
-- Setcode: 27263369
--
-- Effect Text:
-- 7星怪兽×3
-- 「俱舍怒威族·阿莱斯哈特」在「俱舍怒威族的香格里拉茧」把效果发动的回合有1次也能在自己的「俱舍怒威族」怪兽上面重叠来超量召唤。
-- ①：被送去墓地的卡不去墓地而除外。
-- ②：每次卡被除外发动（同一连锁上最多1次）。选除外中的1张卡作为这张卡的超量素材。
-- ③：双方回合1次，把这张卡3个超量素材取除，以场上1张卡为对象才能发动。那张卡里侧表示除外。
--[[ __CARD_HEADER_END__ ]]

--クシャトリラ・アライズハート
local s,id,o=GetID()
function s.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,3,s.ovfilter,aux.Stringid(id,0),3,s.xyzop)
	c:EnableReviveLimit()
	--macro cosmos
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	e1:SetTargetRange(LOCATION_DECK,LOCATION_DECK)
	e1:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e1)
	--material
	local custom_code=aux.RegisterMergedDelayedEvent_ToSingleCard(c,id,EVENT_REMOVE)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(custom_code)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_CHAIN)
	e2:SetOperation(s.mtop)
	c:RegisterEffect(e2)
	--remove
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,2))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e3:SetCost(s.rmcost)
	e3:SetTarget(s.rmtg)
	e3:SetOperation(s.rmop)
	c:RegisterEffect(e3)
	--
	Duel.AddCustomActivityCounter(id,ACTIVITY_CHAIN,s.chainfilter)
end
function s.chainfilter(re,tp,cid)
	return not re:GetHandler():IsCode(73542331)
end
function s.ovfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x189)
end
function s.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,id)==0
		and (Duel.GetCustomActivityCount(id,tp,ACTIVITY_CHAIN)>0
			or Duel.GetCustomActivityCount(id,1-tp,ACTIVITY_CHAIN)>0) end
	Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function s.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not (c:IsRelateToChain() and c:IsType(TYPE_XYZ)) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local mg=Duel.SelectMatchingCard(tp,Card.IsCanOverlay,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,1,nil)
	if #mg>0 then
		Duel.Overlay(c,mg)
	end
end
function s.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,3,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,3,3,REASON_COST)
end
function s.rmfilter(c,tp)
	return c:IsAbleToRemove(tp,POS_FACEDOWN)
end
function s.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and s.rmfilter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(s.rmfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,s.rmfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function s.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEDOWN,REASON_EFFECT)
	end
end
