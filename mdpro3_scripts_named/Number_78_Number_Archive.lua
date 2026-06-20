--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: No.78 编号系档案馆  (ID: 29085954)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Spellcaster
-- Rank 1
-- ATK 0 | DEF 0
-- Setcode: 23724104
--
-- Effect Text:
-- 1星怪兽×2
-- ①：1回合1次，把这张卡1个超量素材取除才能发动。自己的额外卡组的卡由对方随机选1张。那是「No.1」～「No.99」其中任意种的「No.」怪兽的场合，那只怪兽在自己场上的这张卡上面重叠当作超量召唤从
-- 额外卡组特殊召唤。这个效果特殊召唤的怪兽在结束阶段除外。这个效果的发动后，直到回合结束时自己不能把怪兽特殊召唤。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--No.78 ナンバーズ・アーカイブ
function c29085954.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,1,2)
	c:EnableReviveLimit()
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29085954,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c29085954.cost)
	e1:SetTarget(c29085954.sptg)
	e1:SetOperation(c29085954.spop)
	c:RegisterEffect(e1)
end
aux.xyz_number[29085954]=78
function c29085954.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c29085954.filter(c,e,tp,mc)
	local no=aux.GetXyzNumber(c)
	return no and no>=1 and no<=99 and c:IsSetCard(0x48)
		and mc:IsCanBeXyzMaterial(c)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,mc,c)>0
end
function c29085954.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return aux.MustMaterialCheck(e:GetHandler(),tp,EFFECT_MUST_BE_XMATERIAL)
		and Duel.IsExistingMatchingCard(c29085954.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c29085954.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetFieldGroup(tp,LOCATION_EXTRA,0)
	if g:GetCount()>0 and aux.MustMaterialCheck(c,tp,EFFECT_MUST_BE_XMATERIAL)
		and c:IsFaceup() and c:IsRelateToEffect(e) and c:IsControler(tp) and not c:IsImmuneToEffect(e) then
		Duel.ShuffleExtra(tp)
		local tg=g:RandomSelect(1-tp,1)
		Duel.ConfirmCards(1-tp,tg)
		if tg:IsExists(c29085954.filter,1,nil,e,tp,c) then
			local tc=tg:GetFirst()
			local mg=c:GetOverlayGroup()
			if mg:GetCount()~=0 then
				Duel.Overlay(tc,mg)
			end
			tc:SetMaterial(Group.FromCards(c))
			Duel.Overlay(tc,Group.FromCards(c))
			Duel.SpecialSummon(tc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
			local fid=c:GetFieldID()
			tc:RegisterFlagEffect(29085954,RESET_EVENT+RESETS_STANDARD,0,1,fid)
			tc:CompleteProcedure()
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetCode(EVENT_PHASE+PHASE_END)
			e1:SetCountLimit(1)
			e1:SetLabel(fid)
			e1:SetLabelObject(tc)
			e1:SetCondition(c29085954.rmcon)
			e1:SetOperation(c29085954.rmop)
			Duel.RegisterEffect(e1,tp)
		end
	end
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetReset(RESET_PHASE+PHASE_END)
	e2:SetTargetRange(1,0)
	Duel.RegisterEffect(e2,tp)
end
function c29085954.rmcon(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject():GetFlagEffectLabel(29085954)~=e:GetLabel() then
		e:Reset()
		return false
	else return true end
end
function c29085954.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
end
