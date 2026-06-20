--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 铁骑士 基亚·弗里德  (ID: 423705)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 1800 | DEF 1600
--
-- Effect Text:
-- ①：这张卡有装备卡被装备的场合发动。那些装备卡破坏。
--[[ __CARD_HEADER_END__ ]]

--鉄の騎士 ギア・フリード
function c423705.initial_effect(c)
	--destroy equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(423705,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_EQUIP)
	e1:SetTarget(c423705.destg)
	e1:SetOperation(c423705.desop)
	c:RegisterEffect(e1)
end
function c423705.filter(c,ec)
	return c:GetEquipTarget()==ec
end
function c423705.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dg=eg:Filter(c423705.filter,nil,e:GetHandler())
	Duel.SetTargetCard(dg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,dg:GetCount(),0,0)
end
function c423705.desop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	Duel.Destroy(tg,REASON_EFFECT)
end
