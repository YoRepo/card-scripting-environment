--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 异星的最终战士  (ID: 86099788)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Warrior
-- Level 7
-- ATK 2350 | DEF 2300
--
-- Effect Text:
-- 「暗黑英雄 尸魔侠」＋「魔力吸收球体」
-- 这张卡特殊召唤时，其他的自己的场上的怪兽全部破坏。只要这张卡在场上存在，互相的其他的怪兽不能召唤·反转召唤·特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--異星の最終戦士
function c86099788.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,71466592,88472456,true,true)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(86099788,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c86099788.target)
	e1:SetOperation(c86099788.operation)
	c:RegisterEffect(e1)
	--disable summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	c:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetCode(EFFECT_CANNOT_SUMMON)
	c:RegisterEffect(e4)
end
function c86099788.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c86099788.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,aux.ExceptThisCard(e))
	Duel.Destroy(g,REASON_EFFECT)
end
