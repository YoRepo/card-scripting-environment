--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 同盟运输车  (ID: 83152482)
-- Type: Monster / Effect / Link
-- Attribute: LIGHT
-- Race: Machine
-- ATK 1000 | LINK
--
-- Effect Text:
-- 种族或者属性相同的怪兽2只
-- 这个卡名的效果1回合只能使用1次。这张卡在连接召唤的回合不能作为连接素材。
-- ①：以自己场上1只表侧表示怪兽为对象才能发动。从手卡·卡组选原本种族或者原本属性和作为对象的怪兽相同的1只怪兽当作攻击力上升1000的装备卡使用给作为对象的怪兽装备。这个效果从卡组装备的场合，直到回合
-- 结束时自己不能把那张装备的怪兽卡以及那些同名怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ユニオン・キャリアー
function c83152482.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,nil,2,2,c83152482.lcheck)
	--cannot link material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
	e1:SetValue(c83152482.lmlimit)
	c:RegisterEffect(e1)
	--equip
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(83152482,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,83152482)
	e2:SetTarget(c83152482.eqtg)
	e2:SetOperation(c83152482.eqop)
	c:RegisterEffect(e2)
end
function c83152482.lcheck(g,lc)
	if #g<2 then return false end
	local c1=g:GetFirst()
	local c2=g:GetNext()
	return c1:GetLinkAttribute()&c2:GetLinkAttribute()>0 or c1:GetLinkRace()&c2:GetLinkRace()>0
end
function c83152482.lmlimit(e)
	local c=e:GetHandler()
	return c:IsStatus(STATUS_SPSUMMON_TURN) and c:IsSummonType(SUMMON_TYPE_LINK)
end
function c83152482.cfilter(c,tp)
	return c:IsFaceup()
		and Duel.IsExistingMatchingCard(c83152482.eqfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,c:GetOriginalAttribute(),c:GetOriginalRace(),tp)
end
function c83152482.eqfilter(c,att,race,tp)
	return c:IsType(TYPE_MONSTER) and (c:GetOriginalAttribute()==att or c:GetOriginalRace()==race)
		and c:CheckUniqueOnField(tp) and not c:IsForbidden()
end
function c83152482.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c83152482.cfilter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c83152482.cfilter,tp,LOCATION_MZONE,0,1,nil,tp)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c83152482.cfilter,tp,LOCATION_MZONE,0,1,1,nil,tp)
end
function c83152482.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local g=Duel.SelectMatchingCard(tp,c83152482.eqfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,tc:GetOriginalAttribute(),tc:GetOriginalRace(),tp)
		local sc=g:GetFirst()
		if not sc then return end
		local res=sc:IsLocation(LOCATION_DECK)
		if not Duel.Equip(tp,sc,tc) then return end
		--equip limit
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetLabelObject(tc)
		e1:SetValue(c83152482.eqlimit)
		sc:RegisterEffect(e1)
		--atk up
		local e2=Effect.CreateEffect(sc)
		e2:SetType(EFFECT_TYPE_EQUIP)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetValue(1000)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		sc:RegisterEffect(e2)
		if res then
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_FIELD)
			e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
			e3:SetTargetRange(1,0)
			e3:SetLabel(sc:GetCode())
			e3:SetTarget(c83152482.splimit)
			e3:SetReset(RESET_PHASE+PHASE_END)
			Duel.RegisterEffect(e3,tp)
		end
	end
end
function c83152482.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c83152482.splimit(e,c)
	return c:IsCode(e:GetLabel())
end
