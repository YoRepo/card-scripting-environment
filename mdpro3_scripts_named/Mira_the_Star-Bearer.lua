--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 巨星之米拉  (ID: 60181553)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Warrior
-- Rank 1
-- ATK 1100 | DEF 1000
--
-- Effect Text:
-- 1星怪兽×3
-- 场上表侧表示存在的这张卡被破坏的场合，可以作为代替把这张卡1个超量素材取除。此外，只要这张卡在场上表侧表示存在，自己场上表侧表示存在的4星以下的怪兽不会被卡的效果破坏。
--[[ __CARD_HEADER_END__ ]]

--巨星のミラ
function c60181553.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,1,3)
	c:EnableReviveLimit()
	--destroy replace
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c60181553.reptg)
	e1:SetOperation(c60181553.repop)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c60181553.indtg)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c60181553.indtg(e,c)
	return c:IsFaceup() and c:IsLevelBelow(4)
end
function c60181553.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_EFFECT)
		and not e:GetHandler():IsReason(REASON_REPLACE) end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c60181553.repop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_EFFECT)
end
