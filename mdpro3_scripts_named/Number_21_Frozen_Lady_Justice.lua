--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: No.21 冰结之正义女郎  (ID: 57707471)
-- Type: Monster / Effect / Xyz
-- Attribute: WATER
-- Race: Aqua
-- Rank 6
-- ATK 500 | DEF 500
-- Setcode: 72
--
-- Effect Text:
-- 6星怪兽×2
-- 这张卡也能从自己场上的5阶超量怪兽把1个超量素材取除，在那只超量怪兽上面重叠来超量召唤。
-- ①：这张卡的攻击力上升这张卡的超量素材数量×1000。
-- ②：1回合1次，把这张卡1个超量素材取除才能发动。对方场上的守备表示怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--No.21 氷結のレディ・ジャスティス
function c57707471.initial_effect(c)
	c:EnableReviveLimit()
	--xyz summon
	aux.AddXyzProcedure(c,nil,6,2,c57707471.ovfilter,aux.Stringid(57707471,0),2,c57707471.xyzop)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c57707471.atkval)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(57707471,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCost(c57707471.descost)
	e3:SetTarget(c57707471.destg)
	e3:SetOperation(c57707471.desop)
	c:RegisterEffect(e3)
end
aux.xyz_number[57707471]=21
function c57707471.ovfilter(c)
	return c:IsFaceup() and c:IsXyzType(TYPE_XYZ) and c:IsRank(5)
end
function c57707471.xyzop(e,tp,chk,mc)
	if chk==0 then return mc:CheckRemoveOverlayCard(tp,1,REASON_COST) end
	mc:RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c57707471.atkval(e,c)
	return c:GetOverlayCount()*1000
end
function c57707471.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c57707471.desfilter(c)
	return c:IsDefensePos()
end
function c57707471.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c57707471.desfilter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c57707471.desfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c57707471.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c57707471.desfilter,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
