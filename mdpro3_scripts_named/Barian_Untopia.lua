--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 冀望乡-异晶人界-  (ID: 30761649)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 374
--
-- Effect Text:
-- 这个卡名在规则上也当作「异晶人的」卡使用。
-- ①：自己场上的「混沌超量」怪兽、「混沌No.」怪兽、「No.101」～「No.107」的「No.」怪兽不会成为对方的效果的对象，不会被对方的效果破坏。
-- ②：1回合1次，自己用「升阶魔法」魔法卡的效果对超量怪兽的特殊召唤成功的场合，以那1只超量怪兽和对方场上1只怪兽为对象才能发动。那只对方怪兽在那只超量怪兽下面重叠作为超量素材。
--[[ __CARD_HEADER_END__ ]]

--冀望郷－バリアン－
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Untargetable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetRange(LOCATION_FZONE)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(s.immtg)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	--Indes
	local e3=e2:Clone()
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetValue(aux.indoval)
	c:RegisterEffect(e3)
	--Draw
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,0))
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(s.xyzcon)
	e4:SetTarget(s.xyztg)
	e4:SetOperation(s.xyzop)
	c:RegisterEffect(e4)
end
function s.immtg(e,c)
	if c:IsSetCard(0x1073,0x1048) then return true end
	local no=aux.GetXyzNumber(c)
	return c:IsSetCard(0x48) and no and no>=101 and no<=107
end
function s.cfilter(c,tp)
	return c:IsFaceup() and c:IsSummonPlayer(tp) and c:IsType(TYPE_XYZ)
		and c:GetSpecialSummonInfo(SUMMON_INFO_TYPE)&TYPE_SPELL~=0 and c:IsSpecialSummonSetCard(0x95)
end
function s.xyzcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.cfilter,1,nil,tp)
end
function s.tgfilter1(c,g,tp)
	return g:IsContains(c) and Duel.IsExistingTarget(s.tgfilter2,tp,0,LOCATION_MZONE,1,c)
end
function s.tgfilter2(c)
	return c:IsCanOverlay()
end
function s.xyztg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local g=eg:Filter(s.cfilter,nil,tp)
	if chk==0 then return Duel.IsExistingTarget(s.tgfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,g,tp) end
	local tg1
	if g:GetCount()==1 then
		tg1=g
		Duel.SetTargetCard(g)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		tg1=Duel.SelectTarget(tp,s.tgfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,g,tp)
	end
	e:SetLabelObject(tg1:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	Duel.SelectTarget(tp,s.tgfilter2,tp,0,LOCATION_MZONE,1,1,tg1)
end
function s.xyzop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if #g~=2 then return end
	local tc1=e:GetLabelObject()
	local tc2=g:Filter(Card.IsControler,tc1,1-tp):GetFirst()
	if tc1:IsType(TYPE_XYZ) and tc1:IsFaceup() and not tc1:IsImmuneToEffect(e) and tc2 and not tc2:IsImmuneToEffect(e) and tc2:IsControler(1-tp) and tc2:IsType(TYPE_MONSTER) then
		local og=tc2:GetOverlayGroup()
		if og:GetCount()>0 then
			Duel.SendtoGrave(og,REASON_RULE)
		end
		Duel.Overlay(tc1,tc2)
	end
end
