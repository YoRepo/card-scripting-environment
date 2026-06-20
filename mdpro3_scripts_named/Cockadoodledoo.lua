--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 喔喔公鸡  (ID: 42338879)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Winged Beast
-- Level 5
-- ATK 1600 | DEF 2000
--
-- Effect Text:
-- ①：双方场上没有怪兽存在的场合，这张卡可以作为3星怪兽从手卡特殊召唤。
-- ②：对方场上有怪兽存在，自己场上没有卡存在的场合，这张卡可以作为4星怪兽从手卡特殊召唤。
-- ③：表侧表示的这张卡从场上离开的场合除外。
--[[ __CARD_HEADER_END__ ]]

--こけコッコ
function c42338879.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c42338879.spcon)
	e1:SetOperation(c42338879.spop)
	c:RegisterEffect(e1)
	--redirect
	aux.AddBanishRedirect(c)
end
function c42338879.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return (Duel.GetFieldGroupCount(tp,LOCATION_MZONE,LOCATION_MZONE)==0
		or (Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,0)==0 and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0))
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
function c42338879.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_LEVEL)
	if Duel.GetFieldGroupCount(tp,LOCATION_MZONE,LOCATION_MZONE)==0 then
		e1:SetValue(3)
	else
		e1:SetValue(4)
	end
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
end
