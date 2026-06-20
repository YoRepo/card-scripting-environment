--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 魔法偏转器  (ID: 96474800)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个回合，场上的装备·场地·永续·速攻魔法卡的效果无效。
--[[ __CARD_HEADER_END__ ]]

--マジック・ディフレクター
function c96474800.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c96474800.activate)
	c:RegisterEffect(e1)
end
function c96474800.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e1:SetTarget(c96474800.distg)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	--disable effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetOperation(c96474800.disop)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
function c96474800.distg(e,c)
	local tpe=c:GetType()
	return bit.band(tpe,TYPE_SPELL)~=0 and bit.band(tpe,TYPE_EQUIP+TYPE_FIELD+TYPE_CONTINUOUS+TYPE_QUICKPLAY)~=0
end
function c96474800.disop(e,tp,eg,ep,ev,re,r,rp)
	local tl=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	local tpe=re:GetActiveType()
	if bit.band(tl,LOCATION_SZONE)~=0 and bit.band(tpe,TYPE_SPELL)~=0 and bit.band(tpe,TYPE_EQUIP+TYPE_FIELD+TYPE_CONTINUOUS+TYPE_QUICKPLAY)~=0 then
		Duel.NegateEffect(ev)
	end
end
