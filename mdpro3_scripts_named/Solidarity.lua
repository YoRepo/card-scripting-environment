--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 一族的团结  (ID: 86780027)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己墓地的全部怪兽的原本种族相同的场合，自己场上的那个种族的怪兽的攻击力上升800。
--[[ __CARD_HEADER_END__ ]]

--一族の結束
function c86780027.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c86780027.tg)
	e2:SetValue(800)
	c:RegisterEffect(e2)
end
function c86780027.tg(e,c)
	local tp=e:GetHandlerPlayer()
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_MONSTER)
	if g:GetCount()==0 or g:GetClassCount(Card.GetOriginalRace)>1 then return false end
	return c:IsRace(g:GetFirst():GetOriginalRace())
end
